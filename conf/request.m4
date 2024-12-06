route{

	if (!mf_process_maxfwd_header("10")) {
		send_reply("483","Too Many Hops");
		exit;
	}

	if (has_totag()) {

		# handle hop-by-hop ACK (no routing required)
		if ( is_method("ACK") && t_check_trans() ) {
			t_relay();
			exit;
		}

		# sequential request within a dialog should
		# take the path determined by record-routing
		if ( !loose_route() ) {
			# we do record-routing for all our traffic, so we should not
			# receive any sequential requests without Route hdr.
			send_reply("404","Not here");
			exit;
		}

		if (is_method("BYE")) {
			# do accounting even if the transaction fails
			do_accounting("log","failed");
		}

		# route it out to whatever destination was set by loose_route()
		# in $du (destination URI).
		route(relay);
		exit;
	}

	# CANCEL processing
	if (is_method("CANCEL")) {
		if (t_check_trans())
			t_relay();
		exit;
	}

	# absorb retransmissions, but do not create transaction
	t_check_trans();

	if ( !(is_method("REGISTER")  ) ) {
		
		if (is_myself("$fd")) {
					
		} else {
			# if caller is not local, then called number must be local
			
			if (!is_myself("$rd")) {
				send_reply("403","Relay Forbidden");
				exit;
			}
		}

	}

	# preloaded route checking
	if (loose_route()) {
		xlog("L_ERR",
			"Attempt to route with preloaded Route's [$fu/$tu/$ru/$ci]");
		if (!is_method("ACK"))
			send_reply("403","Preload Route denied");
		exit;
	}

	# record routing
	if (!is_method("REGISTER|MESSAGE"))
		record_route();

	# account only INVITEs
	if (is_method("INVITE")) {
		
		do_accounting("log");
	}

	
	if (!is_myself("$rd")) {
		append_hf("P-hint: outbound\r\n"); 
		
		route(relay);
	}

	# requests for my domain
	
	if (is_method("PUBLISH|SUBSCRIBE")) {
		send_reply("503", "Service Unavailable");
		exit;
	}

	if (is_method("REGISTER")) {
				
		if (!save("location"))
			sl_reply_error();

		exit;
	}

	if ($rU==NULL) {
		# request with no Username in RURI
		send_reply("484","Address Incomplete");
		exit;
	}

	# do lookup with method filtering
	if (!lookup("location","m")) {
		t_reply("404", "Not Found");
		exit;
	}

	# when routing via usrloc, log the missed calls also
	do_accounting("log","missed");
	route(relay);
}
