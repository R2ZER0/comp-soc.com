import vibe.d;

void index(HTTPServerRequest req, HTTPServerResponse res)
{
    res.redirect("/home");
}

void home(HTTPServerRequest req, HTTPServerResponse res)
{
    res.renderCompat!("index.dt", typeof(res), "res")(res);
}

shared static this()
{
    auto router = new URLRouter;
    router.get("/", &index);
    router.get("/home", &home);
    
    router.get("/public/*", serveStaticFiles("."));
    
    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    
    listenHTTP(settings, router);
}