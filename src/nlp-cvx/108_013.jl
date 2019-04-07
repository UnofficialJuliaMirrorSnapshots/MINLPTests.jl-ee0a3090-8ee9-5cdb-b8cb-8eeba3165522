function nlp_cvx_108_013(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, x >= 0)
    @variable(m, y >= 0)
    
    @objective(m, Min, x^2 + y^2)
    @NLconstraint(m, 2*x^2 - 4x*y - 4*x + 4 <= y)
    @NLconstraint(m, y^2 <= -x+2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 0.8112507770394088, tol = objective_tol)
    check_solution([x,y], [0.6557120892286371, 0.6174888121082234], tol = primal_tol)
    
end

