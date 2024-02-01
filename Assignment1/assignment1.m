function TransformedImage = transformImage(InputImage, TransformMatrix,TransformType)
    InputImage = im2double(InputImage);
    InputImage = rgb2gray(InputImage);

    A = TransformMatrix;
    
    [h,w] = size(InputImage);
    
    a = [1,1];
    b = [w,1];
    c = [1,h];
    d = [w,h];
    
    % acornerprime = A * [a';1];
    % bcornerprime = A * [b';1];
    % ccornerprime = A * [c';1];
    % dcornerprime = A * [d';1];
    
    cornersprime = A * [a',b',c',d';
                    1, 1, 1, 1];
    % cornersprime needs to have one more step to correctly deal with 
    % a certain kind of transform.
    
    Aprime = [min([1, cornersprime(1,:)]),min([1,cornersprime(2,:)])];
    Bprime = [min([1, cornersprime(1,:)]),max(cornersprime(2,:))];
    Cprime = [max(cornersprime(1,:)),min([1,cornersprime(2,:)])];
    Dprime = [max(cornersprime(1,:)),max(cornersprime(2,:))];
    % Aprime through Cprime need to have their mins altered to deal with
    % a set of transforms
    
    minx = min(cornersprime(1,:)); 
    miny = min(cornersprime(2,:));
    maxx = max(cornersprime(1,:)); 
    maxy = max(cornersprime(2,:));
    
    wprime = maxx - minx + 1;
    hprime = maxy - miny + 1;
    
    [Xprime,Yprime] = meshgrid( minx:maxx, miny:maxy );
    
    pprime = [Xprime(:)';Yprime(:)';ones(1,numel(Xprime))];
    
    if (strcmp(TransformType, "rotation"))
        Ainv = [ A(1,1), -A(1,2), 0; -A(2,1), A(2,2), 0; 0, 0, 1];

    elseif (strcmp(TransformType, "shear"))
        Ainv = [ A(1,1), -A(1,2), 0; -A(2,1), A(2,2), 0; 0, 0, 1];

    elseif (strcmp(TransformType, "scaling"))
        Ainv = [ (1/A(1,1)), 0, 0; 0, (1/A(2,2)), 0; 0, 0, 1];

    elseif (strcmp(TransformType, "translation"))
        Ainv = [ A(1,1), 0, -A(1,3); 0, A(2,2), -A(2, 3); 0, 0, 1];

    elseif (strcmp(TransformType, "reflection"))
        Ainv = A;

    elseif (strcmp(TransformType, "affine"))
        Ainv = inv( A );  % affine transform, and homography

    elseif (strcmp(TransformType, "homography"))
        Ainv = inv( A );  % affine transform, and homography

    end

    phat = Ainv * pprime;
    xhat = phat(1,:);
    yhat = phat(2,:);
    what = phat(3,:);
    
    x = xhat ./ what;
    y = yhat ./ what;
    
    x = reshape( x', hprime, wprime );
    y = reshape( y', hprime, wprime );
    
    Iprime = interp2( InputImage, x, y );
end