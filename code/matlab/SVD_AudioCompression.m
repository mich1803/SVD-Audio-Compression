clear
clc 

% Script to download song, convert to spectrogram, compress using SVD, reconstruct using Griffin-Lim, and plot/compare

% Download the song (if not already downloaded)
url = 'https://raw.githubusercontent.com/mich1803/SVD-Audio-Compression/main/example%20songs%20to%20convert/Tory%20Lanez%20-%20Lavender%20Sunflower.wav';
filename = 'audio.wav';

if ~exist(filename, 'file')
    disp('Downloading audio file...');
    websave(filename, url);
end

% Parameters for spectrogram and compression
window = hann(1024);
overlap = 512;
nfft = 1024;
fs = 44100;
k = 250; % Number of singular values to keep for compression

% Step 1: Convert audio to spectrogram
[S_original, f, t] = audio_to_spectrogram(filename, window, overlap, nfft, fs);

% Step 2: Compress spectrogram using SVD
S_compressed = compress_image_with_svd(abs(S_original), k);

% Step 3: Reconstruct audio from compressed spectrogram using Griffin-Lim
audio_reconstructed = spectrogram_to_audio(S_compressed .* exp(1i*angle(S_original)), window, overlap, nfft, fs, 10);

% Step 4: Plot original and compressed spectrograms
figure;
subplot(2,1,1);
imagesc(t, f, log(abs(S_original)));
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Original Spectrogram');
colorbar;

subplot(2,1,2);
imagesc(t, f, log(abs(S_compressed)));
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Compressed Spectrogram (k=250)');
colorbar;

% Step 5: Listen to original and reconstructed audio
disp('Playing original audio...');
soundsc(y, fs);
pause(length(y)/fs);

disp('Playing reconstructed audio...');
soundsc(audio_reconstructed, fs);


