function nlp_cvx_103_010(optimizer, objective_tol, primal_tol, dual_tol,
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
    #   014 - intersection point
    
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Min, y)
    @NLconstraint(m, x^2 <= y)
    @NLconstraint(m, -x^2 + 1 >= y)
    
    optimize!(m)
    
    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, 0, tol = objective_tol)
    check_solution([x,y], [0, 0], tol = primal_tol)
    
end

