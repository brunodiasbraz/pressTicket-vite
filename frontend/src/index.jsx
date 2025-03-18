import React from "react";
import { createRoot } from "react-dom/client";
import CssBaseline from "@material-ui/core/CssBaseline";

import App from "./App";

// ReactDOM.render(
// 	<CssBaseline>
// 		<App />
// 	</CssBaseline>,
// 	document.getElementById("root")
// );

createRoot(document.getElementById("root")).render(
  <CssBaseline>
    <App />
  </CssBaseline>
);
