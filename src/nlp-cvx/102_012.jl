function nlp_cvx_102_012(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET_LOCAL,
        primal_target = PRIMAL_TARGET_LOCAL)
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Max, x+y)
    @NLconstraint(m, x^2 + y^2 <= 1.0)
    @constraint(m, x + y >= 1.2)
    
    optimize!(m)
    
    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, 2/sqrt(2), tol = objective_tol)
    check_solution([x,y], [1/sqrt(2), 1/sqrt(2)], tol = primal_tol)
    
end

