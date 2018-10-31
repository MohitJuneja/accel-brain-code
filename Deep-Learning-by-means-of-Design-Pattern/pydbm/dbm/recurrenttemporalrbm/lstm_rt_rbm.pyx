# -*- coding: utf-8 -*-
import numpy as np
cimport numpy as np
from pydbm.dbm.rtrbm_director import RTRBMDirector
from pydbm.dbm.builders.rnn_rbm_simple_builder import RNNRBMSimpleBuilder
from pydbm.approximation.rtrbmcd.rnn_rbm_cd import RNNRBMCD
from pydbm.optimization.opt_params import OptParams
from pydbm.dbm.recurrent_temporal_rbm import RecurrentTemporalRBM


class RNNRBM(RecurrentTemporalRBM):
    '''
    The `Client` in Builder Pattern,
    
    Build RNN-RBM.
    '''

    def __init__(
        self,
        visible_num,
        hidden_num,
        visible_activating_function,
        hidden_activating_function,
        rnn_activating_function,
        opt_params,
        learning_rate=1e-05
    ):
        '''
        Init.

        Args:
            visible_num:                    The number of units in visible layer.
            hidden_num:                     The number of units in hidden layer.
            visible_activating_function:    The activation function in visible layer.
            hidden_activating_function:     The activation function in hidden layer.
            opt_params:                     is-a `OptParams`.
            learning_rate:                  Learning rate.

        '''
        if isinstance(opt_params, OptParams) is False:
            raise TypeError()

        rtrbm_director = RTRBMDirector(RNNRBMSimpleBuilder())
        rtrbm_director.rtrbm_construct(
            visible_num,
            hidden_num,
            visible_activating_function,
            hidden_activating_function,
            rnn_activating_function,
            RNNRBMCD(
                opt_params=opt_params
            ),
            learning_rate=learning_rate
        )
        self.rbm = rtrbm_director.rbm