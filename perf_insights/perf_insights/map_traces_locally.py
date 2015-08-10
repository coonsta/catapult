# Copyright (c) 2015 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
import argparse
import os
import sys
import traceback

import perf_insights
from perf_insights import local_directory_corpus_driver
from perf_insights import get_trace_handles_query
from perf_insights import map_runner
from perf_insights.results import json_output_formatter


def Main(args):
  parser = argparse.ArgumentParser(
      description='Local bulk trace processing')
  parser.add_argument('trace_directory')
  parser.add_argument('--query')
  parser.add_argument('map_file')

  parser.add_argument('-j', '--jobs', type=int, default=1)
  parser.add_argument('-o', '--output-file')
  parser.add_argument('-s', '--stop-on-error',
                      action='store_true')
  args = parser.parse_args(args)

  if not os.path.exists(args.trace_directory):
    args.error('trace_directory does not exist')
  if not os.path.exists(args.map_file):
    args.error('map does not exist')

  corpus_driver = local_directory_corpus_driver.LocalDirectoryCorpusDriver(
      os.path.abspath(os.path.expanduser(args.trace_directory)))
  if args.query is None:
    query = get_trace_handles_query.GetTraceHandlesQuery.FromString('True')
  else:
    query = get_trace_handles_query.GetTraceHandlesQuery.FromString(
        args.query)

  if args.output_file:
    ofile = open(args.output_file, 'w')
  else:
    ofile = sys.stdout

  output_formatter = json_output_formatter.JSONOutputFormatter(ofile)

  try:
    trace_handles = corpus_driver.GetTraceHandlesMatchingQuery(query)
    runner = map_runner.MapRunner(trace_handles, args.map_file,
                    stop_on_error=args.stop_on_error)
    if runner.Run(jobs=args.jobs, output_formatters=[output_formatter]):
      return 0
    else:
      return 255
  finally:
    if ofile != sys.stdout:
      ofile.close()