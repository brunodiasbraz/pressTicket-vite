import React, { createContext } from "react";

import useAuth from "../../hooks/useAuth.js/index.js";

export const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
	const { loading, user, isAuth, handleLogin, handleLogout } = useAuth();

	return (
		<AuthContext.Provider
			value={{ loading, user, isAuth, handleLogin, handleLogout }}
		>
			{children}
		</AuthContext.Provider>
	);
};

// export { AuthContext, AuthProvider };
