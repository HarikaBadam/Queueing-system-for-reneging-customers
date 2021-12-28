function [nbrleft,nbrdeparted,customer,lefttime] = function1(mu)

lambda=25/60; %arrival rate
endtime=10*60; %simulation length (minutes)
rng(1);
t=0; %current time
currcustomers=0; %current number of customers in system
event=zeros(1,3); %constructs vector to keep time
event(1)=exprnd(1/lambda); %time for next arrival1
event(2)=inf; %no next service completion (empty system)
event(3)=1+rand; %time for calculating the waiting time of customers in the queue
nbrdeparted=0; %number of departed customers
nbrarrived=0; %number of customers that have arrived throughout the simulations
maxtime = 8+2*rand; %maximum time a customers waits in the queue - uniformly distributed between 8 to 10 minutes
nbrleft = 0; %number of people who left the queue without taking service 
lefttime = zeros(1,500); %time at which people left the queue without taking service
queuelength = 6; %maximum queue length
customer = []; %tells which arrival is leaving the queue without taking service 
departedtime = [];
while t<endtime
    [t,nextevent]=min(event);
    if nextevent==1 && currcustomers <= queuelength+1
        event(1)=exprnd(1/lambda)+t;
        currcustomers=currcustomers+1;
        nbrarrived=nbrarrived+1; %one more customer has arrived to the system through the simulations
        arrivedtime(nbrarrived)=t; %the new customer arrived at time t
        if currcustomers==1
            event(2)=exprnd(1/mu)+t;
        end
        if currcustomers == queuelength +1
            event(1) = inf;
        end
    elseif nextevent==2 
        currcustomers=currcustomers-1;
        timeinsystem=t-arrivedtime(nbrarrived-currcustomers);
        nbrdeparted=nbrdeparted+1;
        departuretime(nbrdeparted) = t;%one more customer has departed%from the system through the%simulations
        T(nbrdeparted)=timeinsystem; %timeinsystem of the customers who took the service
        if currcustomers>0
            event(2)=exprnd(1/mu)+t;
        else
            event(2)=inf;
        end
        if currcustomers == queuelength
            event(1) = t + exprnd(1/lambda);
        end
    else
        if currcustomers > 1 
            for i = 1: nbrarrived
                waitingtime(i) = t - arrivedtime(i); %waiting time of all the customers who have arrived till now
            end
            waitingtime(1:nbrdeparted+1) = 0; %waiting time of the customers who have departed already 
            for i = nbrdeparted+2 : length(waitingtime)
                if waitingtime(i) >= maxtime && currcustomers > 1 && lefttime(i) == 0
                    nbrleft = nbrleft + 1;
                    lefttime(i) = t;
                    currcustomers = currcustomers - 1;
                    customer = [customer,i];
                    i = i+1;
                end
            end
        end
        event(3) = t + rand + 1;
        maxtime = 2*rand + 8;
    end
end
    
fprintf('number of people who arrived in 10 hours = %d', nbrarrived);
fprintf('\nnumber of people who got the service = %d', nbrdeparted);
fprintf('\nnumber of people who have left the system without taking service = %d\n', nbrleft);
end




