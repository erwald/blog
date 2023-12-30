---
layout: layouts/post.njk
title: "Introducing midihum: An ML-Based MIDI Humanizing Tool"
date: 2023-12-30
tags: post
---

# Introducing midihum: An ML-Based MIDI Humanizing Tool

[midihum](https://github.com/erwald/midihum) is a command-line tool for humanizing MIDI -- that is, for taking as input MIDI compositions and producing as output those same compositions with new velocity (loudness/dynamics) values for each of the contained notes. midihum uses gradient boosted trees, with ~400 engineered features, and is trained on 2.6K competition piano performances. You can use it to make your digital compositions sound more natural and expressive, and to find natural climaxes and moments of relaxation in a composition.

Using midihum is easy enough, if you have a basic familiarity with the command line. After installing it, you navigate to the project directory and run

    python main.py humanize /path/to/input.mid /path/to/output.mid

to humanize the MIDI file at `/path/to/input.mid`, saving the humanized file to `/path/to/output.mid`.

I have worked on this tool on and off for the past five years, and have now gotten it to a state with which I am quite happy. It performs well, at least for solo piano works of roughly the type it was trained on, i.e., from the Baroque, Classical, and especially Romantic periods of Western art music. For example, the following plot shows the actual and predicted velocities for nine randomly chosen (not cherry-picked) performances from the validation set. (Each dot is a MIDI "note on" event, i.e., a note being sounded. The notes shown are a randomly sampled subset of those in the composition, to avoid cluttering the plot.) There is a strong correlation between the predicted and actual velocities.[^1]

![img]({{ '/img/midihum_velocity_scatter.png' | url }})

For the same nine pieces, the model also captures the dynamics over the course of the composition well. (It appears less accurate for the Chopin and Haydn pieces below, likely because they are shorter, and less dynamically expressive, than the others shown here.) That is, the tool seems to correctly identify peaks and valleys in the music's intensity, at the macro level.

![img]({{ '/img/midihum_velocities_over_time.png' | url }})

You can also see that the velocities predicted by midihum are more extreme, in the sense that they tend more towards very high and very low values, than those performed by humans. I tuned the model that way because it suits my taste, but this is the result of a scaling factor applied in post-processing, and could easily be toned down to make the two line up better. The difference is especially obvious when comparing the distributions of velocity values, where the tails are somewhat fatter for the distribution of predicted velocities, as shown below.

![img]({{ '/img/midihum_velocity_distributions.png' | url }})

As mentioned, midihum uses gradient boosted trees (via [XGBoost](https://xgboost.readthedocs.io/)) for its model, where each observation is one MIDI "note on" event, with a large (~400, narrowed down from ~1K) set of engineered features. midihum's predictive power is mostly a product of the engineered features, which were largely inspired by instruments used in [technical analysis](https://en.wikipedia.org/wiki/Technical_analysis) of stocks and other securities. Some of the most important features, according to the XGBoost `feature_importances_` attribute, are:

- Features derived from the logarithm of the duration that a note was sustained, for example, [averages of the lowest and highest sustain values in a period, sometimes time-shifted](https://en.wikipedia.org/wiki/Ichimoku_Kink%C5%8D_Hy%C5%8D).
- The note's octave and pitch.
- Features derived from the note's pitch, for example, forward- and backward-looking [oscillators](https://en.wikipedia.org/wiki/Stochastic_oscillator) based on moving averages.
- Features derived from the logarithm of the time passed since a note was last pressed, for example, moving averages and oscillators based on those.

The value of some engineered features was obvious before even training the model. Some of the features had correlations with the outcome (the actual velocity) of >0.25 or even >0.3. Those correlations could be considered weak on their own, but when you have many, and partly uncorrelated, such features, and a model that can capture nonlinear relationships, they are a good sign and can get you a long way.

The midihum model was trained on performances from the International Piano-e-Competition for pianists aged 35 and under. midihum is dedicated to those talented young performers, and those who decided on and carried out the recording and publishing of those performances.

NB: midihum does not change the rhythmical timing of notes, nor does it take into account dynamics notated in sheet music. It is distributed with a GPLv3 license, which (quoting [TLDRLegal](https://www.tldrlegal.com/license/gnu-general-public-license-v3-gpl-3)) means you may "copy, distribute and modify the software as long as you track changes/dates in source files. Any modifications to or software including (via compiler) GPL-licensed code must also be made available under the GPL along with build & install instructions." In addition, you may use the tool freely to make music, including music that you earn money from, without crediting me or this project. I wish you the best of luck in doing so. You can find the full license, as well as the code and user instructions, in the [midihum GitHub repository](https://github.com/erwald/midihum).

[^1]: It is possible that some of these compositions were also present in the training set, though in that case, in different performances, by different pianists. I don't think that is the case for all of the nine, however, and midihum has also performed well enough on tests I have done with MIDI compositions that are certain to not be present in the training set, that I am confident that it is at least able to generalise to most piano music in the European art music tradition. (Another point in favour is that some of the most important features are obviously related to dynamics, in a common sense way, e.g., you crescendo on a climax, and slower music tends to be quieter.)
