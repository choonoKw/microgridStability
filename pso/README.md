# Optimization of microgrid stability using the particle swarm optimization

A novel eigenvalue-oriented objective function is designed to coordinate the parameters of controllers for DER power-electronic interfaces, which is a non-smooth and non-convex problem. To solve it, an algorithmic solution is developed by leveraging particle swarm optimization (PSO). Numerical results on typical networked microgrids validate the effectiveness of the presented method in enhancing the dynamic resilience of the system.

## Small-Signal Stability Modeling

Mathematically, the dynamic microgrid system can be modeled by a set of differential-algebraic equations (DAEs) when the power-electronic interfaces are modeled by averaged switch modeling, as given

$$ \dot{\mathbf{x}}&=\boldsymbol{F}\big(\mathbf{x},\mathbf{y},\mathbf k\big)\\
\mathbf{0}&=\boldsymbol{G}\big(\mathbf{x},\mathbf{y},\mathbf k\big), $$
