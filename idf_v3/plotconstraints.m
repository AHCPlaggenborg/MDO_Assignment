function stop = plotconstraints(x,optimValues,state)
persistent iters c10 c20 c30
stop = false;
switch state
    case "init"
        iters = [];
        c10 = [];
        c20 = [];
        c30 = [];
    case "iter"
        [c,~] = constraints_IDF(x);
        [c1,c2,c3]=deal(c(1),c(2),c(3));
        iters = [iters optimValues.iteration];
        c10 = [c10 c1];
        c20 = [c20 c2];
        c30 = [c30 c3];
        grid on
        h(1)=plot(iters,c10,"b-",'DisplayName','MTOW');
        hold on
        h(2)=plot(iters,c20,'DisplayName','Wing Loading');
        h(3)=plot(iters,c30,'DisplayName','Tank volume');
        legend(h)
    case "done"
        % Clean up plots
    % Some solvers also use case "interrupt"
end
end
% function stop = plotconstraints(x,optimValues,state)
% persistent iters c10 c20 c30 c40
% stop = false;
% switch state
%     case "init"
%         iters = [];
%         c10 = [];
%         c20 = [];
%         c30 = [];
%         c40 = [];
%     case "iter"
%         [c,~] = constraints_IDF(x);
%         [c1,c2,c3,c4]=deal(c(1),c(2),c(3),c(4));
%         iters = [iters optimValues.iteration];
%         c10 = [c10 c1];
%         c20 = [c20 c2];
%         c30 = [c30 c3];
%         c40 = [c40 c4];
%         grid on
%         h(1)=plot(iters,c10,"b-",'DisplayName','MTOW');
%         hold on
%         h(2)=plot(iters,c20,'DisplayName','VMO');
%         h(3)=plot(iters,c30,'DisplayName','Wing Loading');
%         h(4)=plot(iters,c40,'DisplayName','Tank volume');
%         legend(h)
%     case "done"
%         % Clean up plots
%     % Some solvers also use case "interrupt"
% end
% end