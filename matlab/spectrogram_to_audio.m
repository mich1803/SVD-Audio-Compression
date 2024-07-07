function audio_reconstructed = spectrogram_to_audio(S, window, overlap, nfft, fs, num_iterations)
    % Use Griffin-Lim algorithm to reconstruct audio from spectrogram
    audio_reconstructed = istft(S, window, overlap, nfft, fs, num_iterations);
end

function x = istft(S, window, overlap, nfft, fs, num_iterations)
    % Perform inverse STFT using Griffin-Lim algorithm
    x = griffin_lim(S, window, overlap, nfft, fs, num_iterations);
end

function x = griffin_lim(S, window, overlap, nfft, fs, num_iterations)
    % Initialize random phase
    x = randn(nfft, 1);
    x_prev = x;
    
    % Griffin-Lim iterations
    for iter = 1:num_iterations
        % Synthesize time-domain signal
        x = stft(x, window, overlap, nfft, fs);
        
        % Replace magnitude with input spectrogram's magnitude
        x = x ./ abs(x) .* S;
        
        % Update time-domain signal
        x = stft(x, window, overlap, nfft, fs);
        
        % Preserve phase information
        x = real(x);
        
        % Normalize amplitude
        x = x / max(abs(x));
    end
end

function x = stft(x, window, overlap, nfft, fs)
    x = spectrogram(x, window, overlap, nfft, fs);
end
