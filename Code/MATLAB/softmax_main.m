function [] = main()

% Load yeast dataset

%X,Y = load('yeast.mat')
%Training data please please please 1200 only
rng(0);

% X = zeros(10,103);
X = random('Normal',0,1,10,103);

% Y = zeros(10,10);
Y = randi([0,1],10,10);

[M,N] = size(X);

n = size(Y,2);

d = M + n;

w = zeros(d,2^(n)-1);
rho = 0.1;
N_i = 2^(n-1)-1;

k = 1;

for i = 1:n
    combs = combnk([1:n],i);
    for j = 1:size(combs,1)
        final_combs{k} = {combs(j,:)};
        k = k+1;
    end
end

for c = 1:2^(n-1)-1
    for i = 1:n
        delta{c,i} = zeros(M);
    end
end

for i = 1:size(final_combs,2)
    y_alpha{i} = zeros(M,n);
    for j = 1:length(final_combs{i}{1})
        y_alpha{i}(:,final_combs{i}{1}) = 1;
    end
    y_alpha{i} = y_alpha{i} .* Y;
end

for m = 1:M
    for i = 1:size(final_combs,2)
        for j = 1:M
            mu{i}(m,j) = double(isequal(y_alpha{i}(j,final_combs{i}{1}),(y_alpha{i}(m,final_combs{i}{1}))));
        end
    end
end

for i = 1:3
    
    alpha_rand = randi(size(final_combs,2),1);
    m_rand = randi(M,1);
    
    if (alpha_rand <=10)
        
        theta_final = theta_cap(y_i,alpha_rand,m_rand);
        
        [max_val,y_star_index] = max(theta_final);
        
        s_alpha  = zeros(M,1);
        s_alpha(y_star_index) = 1;
        
        psi_final = psi(alpha_rand,m_rand,s_alpha - mu{alpha_rand}(m_rand,:)');
        
        gamma = (theta_final'*(s_alpha - mu{alpha_rand}(m_rand,:)'))/(lamba*norm(psi_final)^2 + (rho * N_i * norm(s_alpha - mu{alpha_rand}(m_rand,:)')^2));
        
        if gamma >1
            gamma = 1;
        end
        
        if gamma < 0
            gamma = 0;
        end
    end
    
    mu{alpha_rand}(m_rand,:) = (1 - gamma)*mu{alpha_rand}(m,:) + gamma*s_alpha';
    psi_update = psi_mat(alpha);
    % psi_update is a cell of (d x M)
    
    w(:,alpha_rand) = psi_update * mu{alpha_rand}(m_rand,:);
    
    
end

end