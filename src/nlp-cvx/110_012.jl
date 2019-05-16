function nlp_cvx_110_012(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED, 
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @NLobjective(m, Min, exp(x+y))
    @NLconstraint(m, x^2 + y^2 <= 1.0)
    
    optimize!(m)
    
    check_status(m, termination_target, primal_target)
    check_objective(m, exp(-2/sqrt(2)), tol = objective_tol)
    check_solution([x,y], [-1/sqrt(2), -1/sqrt(2)], tol = primal_tol)
    
end

