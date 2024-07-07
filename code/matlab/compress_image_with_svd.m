function compressed_matrix = compress_image_with_svd(image_matrix, k)
    [U, S, V] = svd(image_matrix);
    compressed_matrix = U(:, 1:k) * S(1:k, 1:k) * V(:, 1:k)';
end
