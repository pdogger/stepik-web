def wsgi_app(env, start_response):
    start_response('200 OK', [('Content-Type', 'text/plain')])
    print("\n".join(env["QUERY_STRING"].split('&')))
    return [bytes("\n".join(env["QUERY_STRING"].split('&')), encoding="utf-8")]
