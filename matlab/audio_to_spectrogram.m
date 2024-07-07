function [S, f, t] = audio_to_spectrogram(audio_file, window, overlap, nfft, fs)
    % Read audio file
    [y, fs] = audioread(audio_file);
    
    % Compute spectrogram using STFT
    [S, f, t] = spectrogram(y, window, overlap, nfft, fs);
end
