close all
clear
clc

% URL of the audio file
audio_url = 'https://raw.githubusercontent.com/mich1803/SVD-Audio-Compression/main/example%20songs%20to%20convert/10sec%20Hypnotize.wav';

% Step 1: Download the audio file
disp('Step 1: Downloading audio file...')
filename = 'audio.wav';
websave(filename, audio_url);

% Step 2: Read the audio file
disp('Step 2: Reading audio file...')
[x, Fs] = audioread(filename);
delete(filename)

% Check if the audio is stereo; if so, convert to mono by averaging channels
if size(x, 2) > 1
    x = mean(x, 2);  % Convert stereo to mono by averaging channels
end
disp('          Playing the original audio...')

tx = (0:length(x)-1)/Fs;
sound(x, Fs)


% Step 3: Convert audio to spectrogram
disp('Step 3: Converting to spectrogram...')
wind = hamming(128);
olen = 64;
nfft = 1024;
s = stft(x,Fs,Window=wind,OverlapLength=olen,FFTLength=nfft);

smag = abs(s);
sphs = angle(s);

% Step 4: Compressing
disp('Step 4: Compressing with SVD...')
comp = input("          Insert components to truncate:");
[U, S, V] = svd(s);
S = S(1:comp, 1:comp);
U = U(:, 1:comp);
V = V(:, 1:comp);

trunc_s = U * S * V';
recomag = abs(trunc_s);
recophs = angle(trunc_s);

% Step 5: Reconstructing audio
disp('Step 5: Reconstructing audio...')
[reco,treco,info] = stftmag2sig(recomag,nfft,Fs,Window=wind,OverlapLength=olen);
disp('          Playing the reconstructed audio...')
sound(reco, Fs)

plot(tx,x,treco+500/Fs,reco+1)
legend("Original","Reconstructed",Location="best")

