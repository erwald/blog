---
layout: layouts/post.njk
title: Gradually Migrating Python Code to asyncio
date: 2022-04-02
tags: post
---

# Gradually Migrating Python Code to `asyncio`

Say we have a Python app that is doing something with the internet. A minimal example would be a program that retrieves the names of a few characters from the [Rick and Morty API](https://rickandmortyapi.com/documentation) and prints the result to standard output. (We could just as well be talking about other I/O tasks, like reading from a file or database.) Let's take that as our specification.

So we write a `_get()` function that, given some path, sends a request to the API and returns the response JSON. Then we write a `_get_character()` function that takes a character identifier (which is just an integer), retrieves the corresponding record from the API using the `_get()` function, plucks the name from the JSON and returns the result (a string). Finally, we call `_get_character()` once for each hardcoded character identifier and print the result.

```python
# main.py
from datetime import datetime
import requests

def _log(message):
    time_format = "%M:%S:%f"
    now_time_str = datetime.now().strftime(time_format)
    print(f"{now_time_str} {message}")

def _get(path):
    url = f"https://rickandmortyapi.com/api/{path}"
    _log(f"fetching {url}")
    response = requests.get(url)
    _log(f"fetched {url}")
    return response.json()

def _get_character(character_id):
    _log(f"getting character with id {character_id}")
    name = _get(f"character/{character_id}")["name"]
    _log(f"got {name}")
    return name

def main():
    characters = [_get_character(character_id) for character_id in [1, 10, 100]]
    _log(characters)

if __name__ == "__main__":
    main()
```

Running this we get:

```
$ python main.py
24:58:472159 getting character with id 1
24:58:472240 fetching https://rickandmortyapi.com/api/character/1
24:58:714354 fetched https://rickandmortyapi.com/api/character/1
24:58:714459 got Rick Sanchez
24:58:714474 getting character with id 10
24:58:714515 fetching https://rickandmortyapi.com/api/character/10
24:58:889829 fetched https://rickandmortyapi.com/api/character/10
24:58:889929 got Alan Rails
24:58:889950 getting character with id 100
24:58:889963 fetching https://rickandmortyapi.com/api/character/100
24:59:061803 fetched https://rickandmortyapi.com/api/character/100
24:59:061928 got Bubonic Plague
24:59:061946 ['Rick Sanchez', 'Alan Rails', 'Bubonic Plague']
```

We retrieve the character records serially, with blocking requests. If speed is not important, this is a fine way of doing it. It is simple and easy to understand and gets the job done. (The whole thing takes 0.59 seconds.) If, however, speed is important, we can do better by executing the requests concurrently. One way to do that is with [`asyncio`](https://docs.python.org/3/library/asyncio.html). (The Rick and Morty API has an endpoint for retrieving multiple character records in one request. That would also solve our problem. But not all APIs are that nice, so let's pretend we have to fetch character records one by one.)

`asyncio` allows us to define **coroutines** by placing the `async` keyword before a function definition:

```python
async def my_func():
    # ...
```

Coroutines are kind of like functions the execution of which can be paused and resumed. They allow us to perform tasks concurrently (possibly on a single thread) which is useful in situations like this one, where we spend a heavy chunk of time waiting for results from network requests. It would be nice if we could do some useful work while waiting, like sending off the next request.

The `my_func()` function returns a coroutine object:

```
>>> my_func()
<coroutine object my_func at 0x7fb88cd8b8c0>
```

Note that the body of `my_func()` hasn't been executed yet. The coroutine is a promise of work, but it needs to be scheduled on an event loop in order to actually be executed. (`asyncio` coroutines are always scheduled using an event loop. There can only be a single event loop running at one time on one thread.) To schedule a coroutine, we can use the `await` keyword:

```python
await my_func()
```

`await` basically says: "Schedule this coroutine to be run, and go do other stuff elsewhere (if there is other stuff to do) until it has completed. When it has completed, continue here." The `await` keyword can only be used from within a coroutine, because it depends on the event loop that coroutines carry around as context.

You can always call normal functions from coroutines, and you can always `await` coroutines from other coroutines, but scheduling coroutines from normal functions requires some care. We can create a new event loop and run a coroutine in it using the `asyncio.run()` function. But there's a rub. Because there can only be one event loop at a time, we can't call `asyncio.run()` from code that is already running with an event loop. The recommended solution is to only call `asyncio.run()` once at the program's entry point.

We are almost ready to port our program. But we also need a way to turn our `_get()` function, which does blocking I/O, into a `_get_async()` coroutine that does asynchronous I/O. The `loop.run_in_executor()` function allows us to do this. When we give it a function, it returns a `Future` object (which is similar to a coroutine). The passed-in function will be executed in a new thread as soon as we `await` this `Future`. (This means that we have to take care that we synchronise any shared resources, for example using mutex locks, though that is not a problem in our `_get()` function.)

Now we have everything we need to speed up our program.

```python
# main.py
import asyncio
from datetime import datetime
import functools
import requests

def _log(message):
    time_format = "%M:%S:%f"
    now_time_str = datetime.now().strftime(time_format)
    print(f"{now_time_str} {message}")

def make_async(func):
    """Decorator that turns a blocking function into an
    asynchronous one (meaning it will return a future). The inner
    function may be executed on a different thread, so any
    resources it uses must be synchronized. This can only be
    called from the main thread (or any other thread with an
    associated event loop)."""
    @functools.wraps(func)
    async def inner(*args, **kwargs):
        loop = asyncio.get_running_loop()
        return await loop.run_in_executor(None, lambda: func(*args, **kwargs))
    return inner

@make_async
def _get_async(path):
    url = f"https://rickandmortyapi.com/api/{path}"
    _log(f"fetching {url}")
    response = requests.get(url)
    _log(f"fetched {url}")
    return response.json()

async def _get_character(character_id):
    _log(f"getting character with id {character_id}")
    json = await _get_async(f"character/{character_id}")
    name = json["name"]
    _log(f"got {name}")
    return name

async def main():
    tasks = [_get_character(character_id) for character_id in [1, 10, 100]]
    characters = await asyncio.gather(*tasks)
    _log(characters)

if __name__ == "__main__":
    asyncio.run(main())
```

Running this we get:

```
$ python main.py
50:46:636609 getting character with id 1
50:46:637376 fetching https://rickandmortyapi.com/api/character/1
50:46:637667 getting character with id 10
50:46:637806 fetching https://rickandmortyapi.com/api/character/10
50:46:637962 getting character with id 100
50:46:638125 fetching https://rickandmortyapi.com/api/character/100
50:46:872084 fetched https://rickandmortyapi.com/api/character/10
50:46:873891 fetched https://rickandmortyapi.com/api/character/100
50:46:874896 got Alan Rails
50:46:876408 fetched https://rickandmortyapi.com/api/character/1
50:46:876459 got Bubonic Plague
50:46:876712 got Rick Sanchez
50:46:876832 ['Rick Sanchez', 'Alan Rails', 'Bubonic Plague']
```

Note that we now send off all three requests before we have received a response for any of them. As a result, this only takes 0.24 seconds to complete (down 60% from 0.59 seconds).

This program is so tiny that it is easy to port the whole thing over to use `asyncio`. But porting large programs is more tricky. There are a number of things we need to be aware of. Here are two important constraints:

- Because coroutines can only be awaited by other coroutines, `async` will sort of "bubble up" through a program, until it reaches a terminus with `asyncio.run()`.
- Because we cannot have multiple event loops at the same time, we cannot use `asyncio.run()` in any function that may be called from a coroutine. We should really only call `asyncio.run()` at the entry point for our program, or at least only in functions that we _know_ will never be called from coroutines.

Given these constraints, there are various ways to go about gradually migrating a large program to use `asyncio`. The way I've done it is to call `asyncio.run()` once (or rarely) at the program's top level, and to create asynchronous alternatives of blocking I/O functions at the bottom level. (Slatkin (2019) recommends two different approaches: one top-down approach and one bottom-up approach. These might work better than mine for very large programs.) This has allowed me to keep some strands of the call hierarchy synchronous while making others asynchronous. Here is how it might look on the bottom level:

```python
# this function is synchronous and can be called from anywhere
def _get(path):
    return requests.get(f"https://rickandmortyapi.com/api/{path}").json()

# this coroutine is asynchronous and must be awaited
@make_async
def _get_async(path):
    return _get(path)
```

Now when I want a function – like `_get_character()` – to make asynchronous requests, I can add `async` and `await` the `_get_async()` coroutine in the function body. Then any functions that call _that_ coroutine will also need `async`, and so on until we reach the top level. But any function that doesn't have `_get_character()` in its call hierarchy can stay synchronous, just like it was before.

This has worked pretty well. One issue that I have run into is trying to port a function that takes a callback. In our previous example, pre-migration, we may have a `_handle_error()` function that takes a function as an argument, invokes it and if an error appears, logs the error and tries again.

```python
# main.py (synchronous version)

def _handle_error(fn, retries = 2):
    try:
        return fn()
    except Exception as e:
        _log(f"got exception: {e}")
        if retries > 0:
            return _handle_error(fn, retries - 1)
        else:
            raise e

# ...

def _get_character(character_id):
    _log(f"getting character with id {character_id}")
    name = _handle_error(lambda: _get(f"character/{character_id}"))["name"]
    _log(f"got {name}")
    return name
```

The problem here is that we cannot give `_handle_error()` a coroutine, because invoking the coroutine as a function just returns a coroutine object (without scheduling it). Nor can we make `_handle_error()` accept either type, because in order for `_handle_error()` to await a coroutine it needs to be a coroutine itself, meaning `async` would ripple through the program. As a result, the asynchronous version of `_get_character()` can't make use of `_handle_error()`.

The least worst solution for this that I was able to find was to add a `_handle_error_async()` function that is just like the sibling it is based on, except that it accepts a coroutine instead of a function. (Specifically, it takes a function that returns a coroutine object. That is because you can only await a coroutine object once, so we need to create a new object every time we retry.) This has the drawback of involving some repetition (which can be mitigated through factoring out common code in a separate function), but the advantage of allowing us to migrate to asynchronous code gradually.

```python
# main.py (asynchronous version)

def _handle_error(fn, retries = 2):
    # ...

async def _handle_error_async(coro_producer, retries = 2):
    try:
        return await coro_producer()
    except Exception as e:
        _log(f"got exception: {e}")
        if retries > 0:
            return await _handle_error_async(coro_producer, retries - 1)
        else:
            raise e

# ...

async def _get_character(character_id):
    _log(f"getting character with id {character_id}")
    json = await _handle_error_async(
        lambda: _get_async(f"character/{character_id}"))
    name = json["name"]
    _log(f"got {name}")
    return name
```

## References

<style>.csl-entry{text-indent: -2em; margin-left: 2em;}</style><div class="csl-bib-body">
  <div class="csl-entry">Slatkin, Brett. 2019. <i>Effective Python: 90 Specific Ways to Write Better Python</i>. Addison-Wesley Professional.</div>
</div>
