close all
clear
clc

% URL of the audio file
audio_url = 'https://raw.githubusercontent.com/mich1803/SVD-Audio-Compression/main/example%20songs%20to%20convert/Tory%20Lanez%20-%20Lavender%20Sunflower.wav';

% Step 1: Download the audio file
disp('Downloading audio file...')
filename = 'Tory Lanez - Lavender Sunflower.wav';
websave(filename, audio_url);
disp('Audio file downloaded.');

% Step 2: Read the audio file
[x, Fs] = audioread(filename);

% Check if the audio is stereo; if so, convert to mono by averaging channels
if size(x, 2) > 1
    x = mean(x, 2);  % Convert stereo to mono by averaging channels
end

% Step 3: Convert audio to spectrogram
window = hamming(512);
overlap = 256;
nfft = 1024;
spectrogram(x, window, overlap, nfft, Fs, 'yaxis');
title('Original Spectrogram');
[original_spectrogram, ~, ~, ~] = spectrogram(x, window, overlap, nfft, Fs);

% Step 4: Perform SVD on the spectrogram
[U, S, V] = svd(original_spectrogram);

% Step 5: Truncate SVD at k = 250 components
k = 250;
U_trunc = U(:, 1:k);
S_trunc = S(1:k, 1:k);
V_trunc = V(:, 1:k);
spectrogram_trunc = U_trunc * S_trunc * V_trunc';

% Step 6: Reconstruct audio from truncated spectrogram using Griffin-Lim algorithm
reconstructed_spectrogram = abs(spectrogram_trunc);
reconstructed_audio = istft(reconstructed_spectrogram, window, overlap, nfft, Fs);
sound(reconstructed_audio, Fs);

% Step 7: Plot original and truncated spectrograms
figure;
subplot(2, 1, 1);
imagesc(log(original_spectrogram + 1));
title('Original Spectrogram (log scale)');
xlabel('Time');
ylabel('Frequency');
colorbar;

subplot(2, 1, 2);
imagesc(log(abs(spectrogram_trunc) + 1));
title('Truncated Spectrogram (log scale)');
xlabel('Time');
ylabel('Frequency');
colorbar;

% Play original audio
disp('Playing original audio...');
sound(x, Fs);

% Pause before playing reconstructed audio
pause(length(x)/Fs);

% Play reconstructed audio
disp('Playing reconstructed audio...');
sound(reconstructed_audio, Fs);

% Clean up - delete downloaded audio file
delete(filename);
disp('Deleted downloaded audio file.');
