cimport numpy as np
from c_sundials cimport N_Vector, realtype
from common_defs cimport RhsFunction, JacFunction

ctypedef np.float_t DTYPE_t

cdef class CV_data:
    cdef np.ndarray yy_tmp, yp_tmp, jac_tmp
    cdef RhsFunction rfn
    cdef JacFunction jac
    cdef bint parallel_implementation
    cdef object user_data

cdef class CVODE:
    cdef N_Vector atol
    cdef void* _cv_mem
    cdef dict options
    cdef bint parallel_implementation, initialized
    cdef CV_data aux_data

    cdef long int N #problem size, i.e. len(y0) = N
    cdef N_Vector y0, y, yp # for 'step' method

    # Functions
    cpdef _init_step(self, DTYPE_t t0, np.ndarray[DTYPE_t, ndim=1] y0)

    cpdef _solve(self, np.ndarray[DTYPE_t, ndim=1] tspan, 
                       np.ndarray[DTYPE_t, ndim=1] y0, hook_fn = *)
