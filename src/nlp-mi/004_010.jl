function nlp_mi_004_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - non-linear objective and linear, quadratic constraints
    # - functions tan, abs, *
    
    m = Model(solver = optimizer)
    
    @variable(m, -1 <= x <= 1)
    @variable(m, y)
    @variable(m, z, Int)
    
    @NLobjective(m, Min, tan(x) + y + x*z + 0.5*abs(y))
    @constraint(m, x^2 + y^2 + z^2 <= 10)
    @constraint(m, -1.2*x - y <= z/1.35)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, -4.576881309190901, tol = objective_tol)
    check_solution([x,y,z], [-0.9969558935432884, -0.077968812655046, 3], tol = primal_tol)
    
end

