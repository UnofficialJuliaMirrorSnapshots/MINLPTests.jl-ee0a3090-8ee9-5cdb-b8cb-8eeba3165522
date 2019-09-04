function nlp_cvx_102_010(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET_LOCAL,
        primal_target = PRIMAL_TARGET_LOCAL)
    # Test Goals:
    # - linear and nonlinear constraints
    # Variants
    #   010 - constraint intersection
    #   011 - one binding constraint (linear)
    #   012 - one binding constraint (nonlienar)
    #   013 - one binding constraint (quadratic objective)
    #   014 - no binding constraints (quadratic objective)
    
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Min, -x)
    @NLconstraint(m, x^2 + y^2 <= 1.0)
    @constraint(m, x + y >= 1.2)
    
    optimize!(m)
    
    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, -0.974165743715913, tol = objective_tol)
    check_solution([x,y], [0.974165743715913, 0.2258342542139504], tol = primal_tol)
    
end

