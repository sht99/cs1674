function [loss] = cross_entropy_loss(scores, correct_class)

cr = scores(correct_class);
total = 0;
for i = 1:4
    cur = scores(i);
    temp = exp(cur);
    total = temp + total;
    
end

loss = -log(exp(cr)/total)
end

