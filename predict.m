function pred = predict(x, mean, sigma)
    pred = 0;

    for i = 1:size(x, 1)
        pred = pred + ztest(x(i), mean, sigma, 'Alpha', 0.95);
    end

end
