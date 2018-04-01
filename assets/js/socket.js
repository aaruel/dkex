// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("info:top", {})
channel.join()
  .receive("ok", resp => { console.log("Connected...", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("change", inc_change => {
    const {change} = inc_change
    $("#hook_hr")[0].innerHTML = `HASHRATE<br><br>${change.hashrate} GH/S`
    $("#hook_dc")[0].innerHTML = `DOKICOINS<br><br>${change.aitemplates * 50}`
    $("#hook_ai")[0].innerHTML = `AI TEMPLATES<br><br>${change.aitemplates}`
    $("#hook_st")[0].innerHTML = `PERFECTION<br><br>${change.sentience}`
})

const get_image = (template) => {
    switch (template) {
        case "monika": return "https://i.imgur.com/BHh9aUb.png";
        case "natsuki": return "https://i.imgur.com/L3UcCC2.png";
        case "sayori": return "https://i.imgur.com/97IMzRJ.png";
        case "yuri": return "https://i.imgur.com/HWsKl5s.png";
        default: return "";
    }
}

channel.on("newblock", inc_change => {
    // returns 5 recent blocks
    const {change} = inc_change
    $("tbody")[0].innerHTML = change.map((block) => {
        return `<tr>
            <td><img src="${get_image(block.template)}" /></td>
            <td><span class="d-inline-block text-truncate" style="max-width: 150px;">${block.hash}</span></td>
            <td>${block.tx}</td>
            <td><span class="d-inline-block text-truncate" style="max-width: 150px;">${block.miner}</span></td>
            <td>${block.size}</td>
        </tr>`
    }).join("\n")
})

export default socket
