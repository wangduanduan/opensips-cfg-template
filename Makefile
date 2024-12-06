export
include dev.env

export
-include prd.env

cfg:
	m4 main.m4 > opensips.cfg
