function nlp_003_013(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED, 
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    # Test Goals:
    # - linear objective as NLobjective and non-linear constraints
    
    m = Model(optimizer)
    
    @variable(m, 0 <= x <= 4)
    @variable(m, 0 <= y <= 4)
    
    @NLobjective(m, Max, x)
    @NLconstraint(m, y >= exp(x-2) - 1.5)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    optimize!(m)
    
    check_status(m, termination_target, primal_target)
    check_objective(m, 3.256512665824449, tol = objective_tol)
    check_solution([x,y], [3.2565126525233166, 2.013148549981813], tol = primal_tol)
    
end

