# Optimization of microgrid stability using the particle swarm optimization

A novel eigenvalue-oriented objective function is designed to coordinate the parameters of controllers for DER power-electronic interfaces, which is a non-smooth and non-convex problem. To solve it, an algorithmic solution is developed by leveraging particle swarm optimization (PSO). Numerical results on typical networked microgrids validate the effectiveness of the presented method in enhancing the dynamic resilience of the system.

## Small-Signal Stability Modeling

Mathematically, the dynamic microgrid system can be modeled by a set of differential-algebraic equations (DAEs) when the power-electronic interfaces are modeled by averaged switch modeling, as given

$$\left \\{ \begin{aligned}
\dot{\mathbf{x}}&=\boldsymbol{F}\big(\mathbf{x},\mathbf{y},\mathbf k\big)\\
\mathbf{0}&=\boldsymbol{G}\big(\mathbf{x},\mathbf{y},\mathbf k\big), 
\end{aligned} \right.$$

where $\mathbf{x} \in \mathbb{R}^n$ is the state variable vector, e.g., state variables in the controller of power-electronic interfaces;  $\mathbf{y} \in \mathbb{R}^m$ is the algebraic variable vector, e.g.,  bus voltage amplitude and angle;
and $\mathbf k \in \mathbb{R}^d$ represents the control parameter vector to be determined.

The dynamic microgrids could have multiple equilibrium points, where  $\boldsymbol{F}=\boldsymbol{0}$ and $\boldsymbol{G}=\boldsymbol{0}$. At one equilibrium point $(\mathbf{x}^{\star},\mathbf{y}^{\star})$, by linearizing the system, we can obtain the small-signal expression as shown below.

$$\begin{equation}
\mathbf{\Delta\dot{  x}}=\left\\{\boldsymbol{F}_\mathbf x(\mathbf k)-\boldsymbol{F}_\mathbf y(\mathbf k) \cdot \boldsymbol{G}^{-1}_\mathbf y(\mathbf k) \cdot \boldsymbol{G}_\mathbf x(\mathbf k)\right\\}\boldsymbol{\Delta{ \mathbf x}},
\end{equation}$$

where $\boldsymbol{F}\_{\mathbf{x}}=\frac{\partial \boldsymbol{F}}{\partial \mathbf{x}}\Big|\_{(\mathbf x=\mathbf x^{\star},\mathbf y=\mathbf y^{\star})}$ and $\boldsymbol{G}\_{\mathbf{x}}=\frac{\partial \boldsymbol{G}}{\partial \mathbf{x}}\Big|\_{(\mathbf x=\mathbf x^{\star},\mathbf y=\mathbf y^{\star})}$
are the Jacobian matrices with respect to the state variables, 
and $\boldsymbol{F}\_{\mathbf{y}}=\frac{\partial \boldsymbol{F}}{\partial \mathbf{y}} \Big|\_{(\mathbf{x}=\mathbf{x}^{\star},\mathbf y=\mathbf y^{\star})}$ and $\boldsymbol{G}\_{\mathbf{y}}=\frac{\partial \boldsymbol{G}}{\partial \mathbf{y}}\Big|\_{(\mathbf x=\mathbf x^{\star},\mathbf y=\mathbf y^{\star})}$ 
are the Jacobian matrices with respect to the algebraic variables.

$\boldsymbol{F}\_\mathbf x(\mathbf k)-\boldsymbol{F}\_\mathbf y(\mathbf k) \cdot \boldsymbol{G}\^{-1}\_\mathbf y(\mathbf k) \cdot \boldsymbol{G}\_\mathbf x(\mathbf k)$ is defined as the state matrix $A \in \mathbb{R}^{n\times n}$ of the dynamic microgrid system, which is a function of $\mathbf k$.

The system's small-signal stability is determined by the eigenanalysis of $A$, as expressed in (\ref{Eq_eig}), where  $\lambda_i$ is the $i^\text{th}$ eigenvalue of $A$, and $\mathbf{v}\_i$ is the $i^\text{th}$ right  eigenvector.
