function nlp_cvx_103_011(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Min, -y)
    @NLconstraint(m, x^2 <= y)
    @NLconstraint(m, -x^2 + 1 >= y)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, -1, tol = objective_tol)
    check_solution([x,y], [0, 1], tol = primal_tol)
    
end

