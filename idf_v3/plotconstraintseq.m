function stop = plotconstraintseq(x,optimValues,state)
persistent iters cc10 cc20 cc30
stop = false;
switch state
    case "init"
        iters = [];
        cc10 = [];
        cc20 = [];
        cc30 = [];
    case "iter"
        [~,ceq] = constraints_IDF(x);
        [cc1,cc2,cc3]=deal(ceq(1),ceq(2),ceq(3));
        iters = [iters optimValues.iteration];
        cc10 = [cc10 cc1];
        cc20 = [cc20 cc2];
        cc30 = [cc30 cc3];
        grid on
        l(1)=plot(iters,cc10,'DisplayName','Consistency W_{str,wing}');
        hold on
        l(2)=plot(iters,cc20,'DisplayName','Consistency W_{fuel}');
        l(3)=plot(iters,cc30,'DisplayName','Consistency C_{L,wing}/C_{D,wing}');
        legend(l)
    case "done"
        % Clean up plots
    % Some solvers also use case "interrupt"
end
end
% function stop = plotconstraintseq(x,optimValues,state)
% persistent iters cc10 cc20 cc30 cc40
% stop = false;
% switch state
%     case "init"
%         iters = [];
%         cc10 = [];
%         cc20 = [];
%         cc30 = [];
%         cc40 = [];
%     case "iter"
%         [~,ceq] = constraints_IDF(x);
%         [cc1,cc2,cc3,cc4]=deal(ceq(1),ceq(2),ceq(3),ceq(4));
%         iters = [iters optimValues.iteration];
%         cc10 = [cc10 cc1];
%         cc20 = [cc20 cc2];
%         cc30 = [cc30 cc3];
%         cc40 = [cc40 cc4];
%         grid on
%         l(1)=plot(iters,cc10,'DisplayName','Consistency W_{str,wing}');
%         hold on
%         l(2)=plot(iters,cc20,'DisplayName','Consistency W_{fuel}');
%         l(3)=plot(iters,cc30,'DisplayName','Consistency C_{L,wing}');
%         l(4)=plot(iters,cc40,'DisplayName','Consistency C_{D,wing}');
%         legend(l)
%     case "done"
%         % Clean up plots
%     % Some solvers also use case "interrupt"
% end
% end