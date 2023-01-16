# Optimization of microgrid stability using the particle swarm optimization

A novel eigenvalue-oriented objective function is designed to coordinate the parameters of controllers for DER power-electronic interfaces, which is a non-smooth and non-convex problem. To solve it, an algorithmic solution is developed by leveraging particle swarm optimization (PSO). Numerical results on typical networked microgrids validate the effectiveness of the presented method in enhancing the dynamic resilience of the system.

## Small-Signal Stability Modeling

Mathematically, the dynamic microgrid system can be modeled by a set of differential-algebraic equations (DAEs) when the power-electronic interfaces are modeled by averaged switch modeling, as given

$$\left \{ \begin{aligned}
\dot{\mathbf{x}}&=\boldsymbol{F}\big(\mathbf{x},\mathbf{y},\mathbf k\big)\\
\mathbf{0}&=\boldsymbol{G}\big(\mathbf{x},\mathbf{y},\mathbf k\big), 
\end{aligned} \right.$$

where $\mathbf{x} \in \mathbb{R}^n$ is the state variable vector, e.g., state variables in the controller of power-electronic interfaces;  $\mathbf{y} \in \mathbb{R}^m$ is the algebraic variable vector, e.g.,  bus voltage amplitude and angle;
and $\mathbf k \in \mathbb{R}^d$ represents the control parameter vector to be determined.
