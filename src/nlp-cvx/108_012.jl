function nlp_cvx_108_012(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED, 
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    m = Model(optimizer)
    
    @variable(m, x >= 0)
    @variable(m, y >= 0)
    
    @objective(m, Min, x^2 + (y-2)^2)
    @NLconstraint(m, 2*x^2 - 4x*y - 4*x + 4 <= y)
    @NLconstraint(m, y^2 <= -x+2)
    
    optimize!(m)
    
    check_status(m, termination_target, primal_target)
    check_objective(m, 0.5927195187027438, tol = objective_tol)
    check_solution([x,y], [0.31567986647277146, 1.2978135998137839], tol = primal_tol)
    
end

