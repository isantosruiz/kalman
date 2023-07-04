classdef KalmanFilter < handle

% KalmanFilter State estimator for linear systems
%
% Contact the author for usage examples.
%
% =================================================================
% The BeerWare License (Revision 69):
% -----------------------------------------------------------------
% I. Santos-Ruiz wrote this file. As long as you retain this notice
% you can do whatever you want with this stuff.
% If we meet some day, and you think this stuff is worth it,
% you can buy me a beer in return.
% =================================================================

    properties
        A   % State-transition matrix
        B   % Control matrix
        C   % Observation matrix
        Q   % Process noise covariance matrix
        R   % Measurement noise covariance matrix
        K   % Kalman gain
        x   % Estimated state
        P   % Estimation error covariance matrix
    end

    methods
        function obj = KalmanFilter(A,B,C,Q,R,Ts)
            obj.A = A;
            obj.B = B;
            obj.C = C;
            obj.Q = Q;
            obj.R = R;
            if nargin > 5
                obj.A = expm(A*Ts);
                obj.B = (obj.A-eye(size(A)))/A*B;
            end
            obj.initialize
        end

        function initialize(obj,x,P)
            if nargin < 2
                obj.x = zeros(size(obj.A,2),1);
            else
                obj.x = x;
            end
            if nargin < 3
                obj.P = eye(size(obj.A));
            else
                obj.P = P;
            end
        end

        function x = predict(obj,u)
            obj.x = obj.A*obj.x + obj.B*u;
            obj.P = obj.A*obj.P*obj.A' + obj.Q;
            x = obj.x;
        end

        function x = correct(obj,y)
            obj.K = obj.P*obj.C'/(obj.C*obj.P*obj.C'+obj.R);
            obj.x = obj.x + obj.K*(y-obj.C*obj.x);
            obj.P = (eye(size(obj.K*obj.C))-obj.K*obj.C)*obj.P;
            x = obj.x;
        end

        function x = estimate(obj,u,y)
            n = size(obj.x,1);
            m = size(y,2);
            x = zeros(n,m);
            for k = 1:m
                x(:,k) = obj.correct(y(:,k));
                obj.predict(u(:,k));
            end
        end
    end
end