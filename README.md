## Code for a signal processing tool using MATLAB

  ![](http://www.ndt.net/article/v08n07/armanav/fig8.gif "Screenshot")


### ► Intro

This repository contains the code for a signal processing tool using MATLAB.
The tool enables the user to select a .wav file and modify it using different audio effect.
Two graphs (frequency and time axes) are ploted in order to analyse the effects of frequency or amplitude variations.
The audio effects implemented are echo, wah-wah, flanger (frequential modualation) and amplitude modulation.

As audio signals may be electronically represented in either digital or analog format, signal processing may occur in either domain. Analog processors operate directly on the electrical signal, while digital processors operate mathematically on the digital representation of that signal.

### ► MATLAB
MATLAB (matrix laboratory) is a numerical computing environment and fourth-generation programming language. Developed by MathWorks, MATLAB allows matrix manipulations, plotting of functions and data, implementation of algorithms, creation of user interfaces, and interfacing with programs written in other languages, including C, C++, Java, and Fortran.

Although MATLAB is intended primarily for numerical computing, an optional toolbox uses the MuPAD symbolic engine, allowing access to symbolic computing capabilities. An additional package, Simulink, adds graphical multi-domain simulation and Model-Based Design for dynamic and embedded systems.

In 2004, MATLAB had around one million users across industry and academia. MATLAB users come from various backgrounds of engineering, science, and economics. MATLAB is widely used in academic and research institutions as well as industrial enterprises.

### ► What is signal processing?
Signal processing is an area of systems engineering, electrical engineering and applied mathematics that deals with operations on or analysis of signals, or measurements of time-varying or spatially varying physical quantities. Signals of interest can include sound, electromagnetic radiation, images, and sensor data, for example biological data such as electrocardiograms, control system signals, telecommunication transmission signals, and many others.
The goals of signal processing can roughly be divided into the following categories.
* Signal acquisition and reconstruction, which involves measuring a physical signal, storing it, and possibly later rebuilding the original signal or an approximation thereof. For digital systems, this typically includes sampling and quantization.
* Quality improvement, such as noise reduction, image enhancement, and echo cancellation.
* Signal compression, including audio compression, image compression, and video compression.
* Feature extraction, such as image understanding and speech recognition.

In communication systems, signal processing may occur at OSI layer 1, the Physical Layer (modulation, equalization, multiplexing, etc.) in the seven layer OSI model, as well as at OSI layer 6, the Presentation Layer (source coding, including analog-to-digital conversion and data compression).

### ► Aplications
The main applications of DSP are audio signal processing, audio compression, digital image processing, video compression, speech processing, speech recognition, digital communications, RADAR, SONAR, seismology and biomedicine. 
Specific examples are speech compression and transmission in digital mobile phones, room correction of sound in Hi-Fi and sound reinforcement applications, weather forecasting, economic forecasting, seismic data processing, analysis and control of industrial processes, medical imaging such as CAT scans and MRI, MP3 compression, computer graphics, image manipulation, Hi-Fi loudspeaker crossovers and equalization, and audio effects for use with electric guitar amplifiers.

### ► Implementation
Depending on the requirements of the application, digital signal processing tasks can be implemented on general purpose computers (e.g. supercomputers, mainframe computers, or personal computers) or with embedded processors that may or may not include specialized microprocessors called digital signal processors.

Often when the processing requirement is not real-time, processing is economically done with an existing general-purpose computer and the signal data (either input or output) exists in data files. This is essentially no different than any other data processing, except DSP mathematical techniques (such as the FFT) are used, and the sampled data is usually assumed to be uniformly sampled in time or space. For example: processing digital photographs with software such as Photoshop.

However, when the application requirement is real-time, DSP is often implemented using specialised microprocessors such as the DSP56000, the TMS320, or the SHARC. These often process data using fixed-point arithmetic, though some more powerful versions use floating point arithmetic. For faster applications FPGAs might be used. Beginning in 2007, multicore implementations of DSPs have started to emerge from companies including Freescale and Stream Processors, Inc.

For faster applications with vast usage, ASICs might be designed specifically. For slow applications, a traditional slower processor such as a microcontroller may be adequate. Also a growing number of DSP applications are now being implemented on Embedded Systems using powerful PCs with a Multi-core processor.

### ► License [MIT](http://opensource.org/licenses/MIT "MIT")

Copyright (c)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

![MIT](http://upload.wikimedia.org/wikipedia/commons/4/42/Opensource.svg "MIT")
