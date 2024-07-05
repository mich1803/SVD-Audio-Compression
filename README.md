![Repository banner](media/aucompsvd_banner.jpg)
# 🎶🗜️ SVD Audio Compression

Leverage [Singular Value Decomposition](  https://en.m.wikipedia.org/wiki/Singular_value_decomposition ) (SVD) for audio compression, aiming to efficiently reduce audio file sizes while maintaining high sound quality. This project uses the mathematical properties of SVD to achieve significant compression ratios without compromising audio integrity. It explores various levels of decomposition and reconstruction to find the optimal balance between compression ratio and audio fidelity.

---

## Contents

### How does SVD on audio works

The project converts audio signals into spectrograms, applies [Singular Value Decomposition](https://en.wikipedia.org/wiki/Singular_value_decomposition) to compress the data, and reconstructs the audio from the compressed spectrogram. The steps include:
1. **Audio to Spectrogram**: Transform the audio signal into its spectrogram representation using Short-Time Fourier Transform (STFT). This breaks down the audio into time-frequency components.
2. **Spectrogram to SVD**: Decompose the spectrogram matrix using SVD, which separates it into singular vectors and values, allowing the reduction of dimensionality.
3. **SVD to Spectrogram**: Truncate the singular values to compress the spectrogram data. The number of singular values retained determines the compression level and quality.
4. **Spectrogram to Audio**: Reconstruct the audio signal from the compressed spectrogram using the Griffin-Lim algorithm.

### Griffin-Lim Algorithm

To improve the quality of the reconstructed audio:
- **Phase Reconstruction**: After applying SVD, the phase information might be lost or altered. The Griffin-Lim algorithm iteratively estimates the phase to enhance the quality of the reconstructed audio from its magnitude spectrogram.

### Memory Space Analysis

In this project, an analysis of the memory space saved by using SVD for audio compression is also included. This involves comparing the original size of audio files to their compressed versions, taking into account various levels of singular value truncation. The analysis highlights the trade-off between compression ratio and audio quality, providing insights into the effectiveness of SVD in reducing storage requirements without significant loss of sound fidelity.

---

## How to Use

### On Google Colab:

1. Open the notebook on [Google Colab](https://colab.research.google.com/).
2. Upload the audio file you want to compress to the file section.
3. Modify the filename in the code to match the uploaded file.

### Locally:

1. Install the requirements with `pip install -r requirements.txt`.
2. Open the `SVD-AudioCompression.ipynb` notebook in your IDE.
3. Change the filename to point to your audio file.
