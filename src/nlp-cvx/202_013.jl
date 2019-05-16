function nlp_cvx_202_013(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED, 
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    @variable(m, z)
    
    @objective(m, Min, x+y+2*z)
    @NLconstraint(m, x^2 + y^2 <= z)
    @NLconstraint(m, x^2 + y^2 <= -z+1)
    
    optimize!(m)
    
    check_status(m, termination_target, primal_target)
    check_objective(m, -1/4, tol = objective_tol)
    check_solution([x,y,z], [-1/4, -1/4, 1/8], tol = primal_tol)
    
end

