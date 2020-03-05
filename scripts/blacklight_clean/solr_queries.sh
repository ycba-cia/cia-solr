#!/bin/bash

curl "http://10.5.96.187:8983/solr/ycba-collections_dev1/select?fq=collection_ss%3A%22Rare+Books+and+Manuscripts%22+%26%26+-timestamp_dt%3A%5BNOW-8DAY+TO+NOW%5D&sort=timestamp_dt+desc&rows=1000&fl=id%2Ctimestamp_dt%2Ctitle_ss%2Cauthor_ss&wt=json&indent=true" -o rb_clean.json

curl "http://10.5.96.187:8983/solr/ycba-collections_dev1/select?fq=collection_ss%3A%22Reference+Library%22+%26%26+-timestamp_dt%3A%5BNOW-8DAY+TO+NOW%5D&sort=timestamp_dt+desc&rows=1000&fl=id%2Ctimestamp_dt%2Ctitle_ss%2Cauthor_ss&wt=json&indent=true" -o ref_clean.json

curl "http://10.5.96.187:8983/solr/ycba-collections_dev1/select?fq=collection_ss%3A%22Prints+and+Drawings%22+%26%26+-timestamp_dt%3A%5BNOW-8DAY+TO+NOW%5D&sort=timestamp_dt+desc&rows=1000&fl=id%2Ctimestamp_dt%2Ctitle_ss%2Cauthor_ss&wt=json&indent=true" -o pd_clean.json

curl "http://10.5.96.187:8983/solr/ycba-collections_dev1/select?fq=collection_ss%3A%22Paintings+and+Sculpture%22+%26%26+-timestamp_dt%3A%5BNOW-8DAY+TO+NOW%5D&sort=timestamp_dt+desc&rows=1000&fl=id%2Ctimestamp_dt%2Ctitle_ss%2Cauthor_ss&wt=json&indent=true" -o ps_clean.json

curl "http://10.5.96.187:8983/solr/ycba-collections_dev1/select?fq=collection_ss%3A%22Frames%22+%26%26+-timestamp_dt%3A%5BNOW-8DAY+TO+NOW%5D&sort=timestamp_dt+desc&rows=1000&fl=id%2Ctimestamp_dt%2Ctitle_ss%2Cauthor_ss&wt=json&indent=true" -o fr_clean.json

curl "http://10.5.96.187:8983/solr/ycba-collections_dev1/select?fq=collection_ss%3A%22Institutional+Archives%22%26%26+-timestamp_dt%3A%5BNOW-8DAY+TO+NOW%5D&sort=timestamp_dt+desc&rows=1000&fl=id%2Ctimestamp_dt%2Ctitle_ss%2Cauthor_ss&wt=json&indent=true" -o ia_clean.json
