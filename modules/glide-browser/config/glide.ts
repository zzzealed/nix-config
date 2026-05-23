/// <reference path="/home/mads/.config/glide/glide.d.ts" />

glide.autocmds.create("UrlEnter", /192\.168\.0\.104/, async () => {
  await glide.excmds.execute("mode_change ignore");
  return () => glide.excmds.execute("mode_change normal");
});
