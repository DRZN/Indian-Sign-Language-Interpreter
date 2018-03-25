# IndianSignLanguage
Translating Images from ISL to English Alphabets 

Translation is conducted by three methods- 
1) Template matching
  a) Haudorff Distance
  b) Phase correlation

2) ANN

All of these have separate files.
allinone contains all these methods for the test data.

A picture is taken, every picture is pre-processed before
feature extraction. 
1) skin segmentation-  ycbcr color model
2) noise reduction
3) edge detection
4) Other feature extractions


These features are fed to the aforementioned methods to
predict the translated letter.
