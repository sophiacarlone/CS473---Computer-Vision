function TransformedImage = transformImage( InputImage, TransformMatrix, TransformType )
    InputImage = im2double(InputImage);
    InputImage = rgb2gray(InputImage);

	% Step 1 ---------------
    [h,w] = size(InputImage);
    
    a = [1,1];
    b = [w,1];
    c = [1,h];
    d = [w,h];
    
    cornersprime = TransformMatrix * [a',b',c',d';
                    1, 1, 1, 1];

    % divide by new wprime for homography
    cornersprime = [cornersprime(1,:)./cornersprime(3,:);
                    cornersprime(2,:)./cornersprime(3,:)];
    
    cornersprime = ceil(cornersprime); % round up when scaling for ints
    
    % find min of 1 and corners
    minx = min([1, cornersprime(1,:)]);
    miny = min([1, cornersprime(2,:)]);
    % find max corner
    maxx = max(cornersprime(1,:));
    maxy = max(cornersprime(2,:));
    
    wprime = maxx - minx + 1;
    hprime = maxy - miny + 1;
    
    [Xprime,Yprime] = meshgrid( minx:maxx, miny:maxy );
    pprime = [Xprime(:)';Yprime(:)';ones(1,numel(Xprime))];
    

	% Step 2 ---------------
    A = TransformMatrix;

	% Step 3 ---------------
    if (strcmp(TransformType, "rotation"))
        Ainv = [ A(1,1), -A(1,2), 0; -A(2,1), A(2,2), 0; 0, 0, 1];

    elseif (strcmp(TransformType, "shear"))
        Ainv = [ A(1,1), -A(1,2), 0; -A(2,1), A(2,2), 0; 0, 0, 1];

    elseif (strcmp(TransformType, "scaling"))
        Ainv = [ (1/A(1,1)), 0, 0; 0, (1/A(2,2)), 0; 0, 0, 1];

    elseif (strcmp(TransformType, "translation"))
        Ainv = [ 1, 0, -A(1,3); 0, 1, -A(2, 3); 0, 0, 1];

    elseif (strcmp(TransformType, "reflection"))
        Ainv = A;

    elseif (strcmp(TransformType, "affine"))
        Ainv = inv( A );

    elseif (strcmp(TransformType, "homography"))
        Ainv = inv( A );
    
    elseif (strcmp(TransformType, "transform"))
        Ainv = inv( A );  %multiple transforms
    
    end

	% Step 4 ---------------
    phat = Ainv * pprime;
    xhat = phat(1,:);
    yhat = phat(2,:);
    what = phat(3,:);
    
    x = xhat ./ what;
    y = yhat ./ what;
    
    x = reshape( x', hprime, wprime );
    y = reshape( y', hprime, wprime );

	% Step 5 --------------
    TransformedImage = interp2( InputImage, x, y );
end
