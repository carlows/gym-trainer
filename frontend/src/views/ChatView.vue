<template>
  <div class="space-y-4">
    <h1 class="text-3xl font-bold tracking-tight">Chat</h1>
    <div class="flex flex-col h-[600px] rounded-xl border bg-card text-card-foreground shadow overflow-hidden">
      <div class="p-6 border-b">
        <h3 class="tracking-tight text-sm font-medium">Hello World Chat</h3>
      </div>
      <div class="flex-1 p-6 overflow-y-auto">
        <p class="text-muted-foreground italic text-center">Start a conversation...</p>
      </div>
      <div class="p-4 border-t bg-muted/50">
        <div class="flex gap-2">
          <div class="flex-1 h-10 px-3 py-2 text-sm border rounded-md bg-background cursor-not-allowed text-muted-foreground">
            Type a message...
          </div>
          <div class="inline-flex items-center justify-center h-10 px-4 py-2 text-sm font-medium border rounded-md bg-primary text-primary-foreground opacity-50 cursor-not-allowed">
            Send
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
