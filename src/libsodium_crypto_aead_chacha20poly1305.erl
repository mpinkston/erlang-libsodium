%% -*- mode: erlang; tab-width: 4; indent-tabs-mode: 1; st-rulers: [70] -*-
%% vim: ts=4 sw=4 ft=erlang noet
%%%-------------------------------------------------------------------
%%% @author Andrew Bennett <andrew@pixid.com>
%%% @copyright 2015-2016, Andrew Bennett
%%% @doc
%%%
%%% @end
%%% Created :  31 Dec 2015 by Andrew Bennett <andrew@pixid.com>
%%%-------------------------------------------------------------------
-module(libsodium_crypto_aead_chacha20poly1305).

-define(NAMESPACE, crypto_aead_chacha20poly1305).

%% API
-export([keybytes/0]).
-export([nsecbytes/0]).
-export([npubbytes/0]).
-export([abytes/0]).
-export([encrypt/3]).
-export([encrypt/4]).
-export([decrypt/3]).
-export([decrypt/4]).
-export([ietf_npubbytes/0]).
-export([ietf_encrypt/3]).
-export([ietf_encrypt/4]).
-export([ietf_decrypt/3]).
-export([ietf_decrypt/4]).

%% Internal API
-export([call/1]).
-export([call/2]).

%%%===================================================================
%%% API
%%%===================================================================

keybytes() ->
	call(keybytes).

nsecbytes() ->
	call(nsecbytes).

npubbytes() ->
	call(npubbytes).

abytes() ->
	call(abytes).

encrypt(M, NPub, K)
		when is_binary(M)
		andalso is_binary(NPub)
		andalso is_binary(K) ->
	encrypt(M, <<>>, NPub, K).

encrypt(M, AD, NPub, K)
		when is_binary(M)
		andalso is_binary(AD)
		andalso is_binary(NPub)
		andalso is_binary(K) ->
	call(encrypt, {M, AD, <<>>, NPub, K}).

decrypt(C, NPub, K)
		when is_binary(C)
		andalso is_binary(NPub)
		andalso is_binary(K) ->
	decrypt(C, <<>>, NPub, K).

decrypt(C, AD, NPub, K)
		when is_binary(C)
		andalso is_binary(AD)
		andalso is_binary(NPub)
		andalso is_binary(K) ->
	call(decrypt, {<<>>, C, AD, NPub, K}).

ietf_npubbytes() ->
	call(ietf_npubbytes).

ietf_encrypt(M, NPub, K)
		when is_binary(M)
		andalso is_binary(NPub)
		andalso is_binary(K) ->
	ietf_encrypt(M, <<>>, NPub, K).

ietf_encrypt(M, AD, NPub, K)
		when is_binary(M)
		andalso is_binary(AD)
		andalso is_binary(NPub)
		andalso is_binary(K) ->
	call(ietf_encrypt, {M, AD, <<>>, NPub, K}).

ietf_decrypt(C, NPub, K)
		when is_binary(C)
		andalso is_binary(NPub)
		andalso is_binary(K) ->
	ietf_decrypt(C, <<>>, NPub, K).

ietf_decrypt(C, AD, NPub, K)
		when is_binary(C)
		andalso is_binary(AD)
		andalso is_binary(NPub)
		andalso is_binary(K) ->
	call(ietf_decrypt, {<<>>, C, AD, NPub, K}).

%%%-------------------------------------------------------------------
%%% Internal functions
%%%-------------------------------------------------------------------

%% @private
call(Function) when is_atom(Function) ->
	call(Function, {}).

%% @private
call(Function, Arguments) when is_atom(Function) andalso is_tuple(Arguments) ->
	libsodium:call(?NAMESPACE, Function, Arguments).