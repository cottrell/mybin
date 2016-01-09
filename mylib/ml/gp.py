import numpy as np
import scipy.spatial.distance as dist

class GP:
    """
    (n, d)-array xtrain and an n-vector ytrain

    gp = GP(sqexp_kernel, sigma=0)
    gp.add_data(xtrain, ytrain)
    mu, s2 = gp.posterior(xtest)
    """

    def __init__(self, kernel, sigma=1.0):
        self.kernel = kernel
        self.sigma = sigma

    def add_data(self, xtrain, ytrain):
        """ append data, update mu and K """
        self.xtrain = xtrain  # hstack(self.xtrain, xtrain)
        self.ytrain = ytrain  # hstack(self.ytrain, ytrain)
        self.K = self.kernel(self.xtrain, self.xtrain)
        self.Ky = self.K + self.sigma ** 2 * eye(self.K.shape[0])

    def posterior(self, xtest):
        """ compute mu_star, K_star, sigma_star """
        Ks = self.kernel(self.xtrain, xtest)
        Kss = self.kernel(xtest, xtest)

        Kyinv = inv(self.Ky)
        KKyT = dot(Ks.T, Kyinv)

        mu = dot(KKyT, self.ytrain)
        Ss = Kss - dot(KKyT, Ks)
        return mu, Ss

def sqexp_kernel(x1, x2, ell=.5, sf2=1.0):
    """ x1 and x2 of size (n, d) and (m, d) """
    d = dist.cdist(x1, x2, 'sqeuclidean')
    k = sf2 * exp(-0.5 * d / ell)
    return k
