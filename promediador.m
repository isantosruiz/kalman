classdef promediador < handle
    properties
        n
        p
    end
    methods
        function obj = promediador
            obj.n = 0;
            obj.p = 0;
        end
        function p = agregar(obj,x)
            obj.n = obj.n + 1;
            obj.p = obj.p + 1/obj.n*(x - obj.p);
            p = obj.p;
        end
    end
end