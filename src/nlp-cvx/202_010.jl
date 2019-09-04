function nlp_cvx_202_010(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET_LOCAL,
        primal_target = PRIMAL_TARGET_LOCAL)
    # Test Goals:
    # - linear objective
    # - intersection convex quadratic constraints
    # Variants
    #   010 - one binding constraint (inflection point)
    #   011 - one binding constraint (inflection point)
    #   012 - one binding constraint (non-inflection point)
    #   013 - one binding constraint (non-inflection point)
    #   014 - intersection set
    
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    @variable(m, z)
    
    @objective(m, Min, -z)
    @NLconstraint(m, x^2 + y^2 <= z)
    @NLconstraint(m, x^2 + y^2 <= -z+1)
    
    optimize!(m)
    
    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, -1, tol = objective_tol)
    check_solution([x,y,z], [0, 0, 1], tol = primal_tol)
    
end

