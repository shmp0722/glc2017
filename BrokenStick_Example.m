function BrokenStick_Example

% Example 1

nstick = 4;
nn = 800;
xx = linspace(1.0, 11.5, nn)';
y0 = sin(xx);
yy = y0 + randn(nn, 1) * 0.4;
ab = BrokenStickRegression(xx, yy, nstick);
plot(xx, yy, 'b.', xx, y0, 'k', ab(:, 1), ab(:, 2), 'r-o')
title(['BrokenStickRegression(x, sin(x) + noise, ', ...
    int2str(nstick), ')'])


%%
figure; hold on;
plot(xx, yy, 'b.')
plot(xx, y0, 'k')
% this is that
plot(ab(:, 1), ab(:, 2), 'r-o')
