%%%%%
%1)

[nbrleft,nbrdeparted,customer,lefttime] = function1(40/60);


%%%%%%%%%%
%2)

clear all;
x = 0.667 :0.0001: 0.84;
for i = 1: length(x)
    [nbrleft(i), nbrdeparted(i)] = function1(x(i));
end
fraction = (nbrleft./(nbrleft + nbrdeparted));
figure;plot(x,nbrleft);
xlabel('mu values');
ylabel('fraction');

