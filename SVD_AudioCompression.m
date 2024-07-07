clear
clc 

% URL of the audio file
url = 'https://raw.githubusercontent.com/mich1803/SVD-Audio-Compression/main/example%20songs%20to%20convert/Tory%20Lanez%20-%20Lavender%20Sunflower.wav';

% Step 1: Download the audio file
disp('Downloading audio file...');
filename = 'audio.wav';
websave(filename, url);

% Step 2: Read the audio file
[y, Fs] = audioread(filename);
y = y(:, 1); % Take only one channel if stereo

% Step 3: Convert audio to spectrogram
disp('Computing spectrogram...');
window = 2048;
noverlap = 1536;
nfft = 4096;
[S, F, T] = spectrogram(y, window, noverlap, nfft, Fs);

% Step 4: Perform Singular Value Decomposition (SVD) of the spectrogram
disp('Performing SVD...');
[U, S_diag, V] = svd(S, 'econ');

% Step 5: Truncate SVD at a chosen component k (input)
k = input('Enter the number of components (k) for truncation: ');

% Truncate matrices
U_truncated = U(:, 1:k);
S_truncated = S_diag(1:k, 1:k);
V_truncated = V(:, 1:k);

% Reconstruct truncated spectrogram
S_reconstructed = U_truncated * S_truncated * V_truncated';

% Step 6: Inverse spectrogram to obtain audio signal
disp('Reconstructing audio using Griffin-Lim algorithm...');
y_reconstructed = istft(S_reconstructed, window, noverlap, nfft, Fs);

% Step 7: Plot original and truncated spectrograms
figure;
subplot(2, 1, 1);
imagesc(T, F, log(abs(S)));
axis xy;
colorbar;
title('Original Spectrogram');
xlabel('Time (s)');
ylabel('Frequency (Hz)');

subplot(2, 1, 2);
imagesc(T, F, log(abs(S_reconstructed)));
axis xy;
colorbar;
title(['Truncated Spectrogram (k = ' num2str(k) ')']);
xlabel('Time (s)');
ylabel('Frequency (Hz)');

% Step 8: Play original and reconstructed audio
disp('Playing original audio...');
sound(y, Fs);
pause(length(y)/Fs + 1); % Wait for the original audio to finish playing

disp('Playing reconstructed audio...');
sound(y_reconstructed, Fs);
