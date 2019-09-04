function nlp_cvx_105_012(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET_LOCAL,
        primal_target = PRIMAL_TARGET_LOCAL)
    m = Model(optimizer)
    
    @variable(m, x, start=0.1)
    @variable(m, y)
    
    @objective(m, Min, x-y)
    @NLconstraint(m, exp(x-2.0) - 0.5 <= y)
    @NLconstraint(m, log(x) + 0.5 >= y)
    
    optimize!(m)
    
    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, 1/2, tol = objective_tol)
    check_solution([x,y], [1, 1/2], tol = primal_tol)
    
end

