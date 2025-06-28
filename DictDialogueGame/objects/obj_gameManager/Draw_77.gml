//ppxRenderer.DrawInFullscreen(application_surface);

// draw lighting system's final surface to the screen.
//crystalRenderer.DrawInFullscreen();


var _inputSurf = application_surface;

// lighting effects first
_inputSurf = crystalRenderer.GetRenderSurface();


// post processing effects second
ppxRenderer.DrawInFullscreen(_inputSurf);
//_inputSurf = objPostProcessing.renderer.GetRenderSurface();